<?php
// src/Controller/AdminController.php

namespace App\Controller;

use App\Entity\Events;
use App\Entity\Users; 
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Security\Http\Attribute\IsGranted;

class AdminController extends AbstractController
{
    #[Route('/admin', name: 'app_admin')]
    #[IsGranted('ROLE_ADMIN')]
    public function index(EntityManagerInterface $entityManager): Response
    {
        // Récupérer tous les utilisateurs, triés par 'username' (ordre alphabétique ASC)
        // La méthode findBy() est utilisée pour ajouter un critère de tri.
        $users = $entityManager->getRepository(Users::class)->findBy(
            [], // Critères de sélection (vide pour tout prendre)
            ['username' => 'ASC'] // Ordre de tri
        );

        // Récupérer tous les événements, triés par 'title' (ordre alphabétique ASC)
        $events = $entityManager->getRepository(Events::class)->findBy(
            [], // Critères de sélection (vide pour tout prendre)
            ['title' => 'ASC'] // Ordre de tri
        );

        return $this->render('admin/index.html.twig', [
            'users' => $users,
            'events' => $events,
        ]);
    }

    // Méthode : Suppression d'un utilisateur par l'administrateur
    #[Route('/admin/user/{id}/delete', name: 'app_user_delete_admin', methods: ['POST'])]
    #[IsGranted('ROLE_ADMIN')]
    public function deleteUser(Request $request, Users $user, EntityManagerInterface $entityManager): Response
    {
        // 1. Vérification du jeton CSRF
        if ($this->isCsrfTokenValid('delete' . $user->getId(), $request->request->get('_token'))) {
            
            // 2. Empêcher l'auto-suppression
            if ($user === $this->getUser()) {
                 $this->addFlash('error', 'Vous ne pouvez pas supprimer votre propre compte administrateur depuis le tableau de bord.');
                 return $this->redirectToRoute('app_admin');
            }

            // 3. Suppression de l'utilisateur
            $entityManager->remove($user);
            $entityManager->flush();

            // 4. Message de confirmation
            $this->addFlash('success', 'L\'utilisateur ' . $user->getUsername() . ' a été supprimé avec succès.');
        } else {
            $this->addFlash('error', 'Token de sécurité invalide.');
        }

        // 5. Redirection vers le tableau de bord
        return $this->redirectToRoute('app_admin');
    }
}