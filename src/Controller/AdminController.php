<?php
// src/Controller/AdminController.php

namespace App\Controller;

use App\Entity\Events;
use App\Entity\Users;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Security\Http\Attribute\IsGranted;

class AdminController extends AbstractController
{
    #[Route('/admin', name: 'app_admin')]
    #[IsGranted('ROLE_ADMIN')]
    public function index(EntityManagerInterface $entityManager): Response
    {
        // Récupérer tous les utilisateurs
        $users = $entityManager->getRepository(Users::class)->findAll();

        // Récupérer tous les événements
        $events = $entityManager->getRepository(Events::class)->findAll();

        return $this->render('admin/index.html.twig', [
            'users' => $users,
            'events' => $events,
        ]);
    }
}