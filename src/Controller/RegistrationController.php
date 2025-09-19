<?php

namespace App\Controller;

use App\Entity\Users;
use App\Form\RegistrationFormType;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\PasswordHasher\Hasher\UserPasswordHasherInterface;
use Symfony\Component\Routing\Attribute\Route;
use Symfony\Bundle\SecurityBundle\Security;
use Symfony\Component\Security\Http\Attribute\IsGranted;

class RegistrationController extends AbstractController
{
    #[Route('/register', name: 'app_register')]
    public function register(Request $request, UserPasswordHasherInterface $userPasswordHasher, EntityManagerInterface $entityManager, Security $security): Response
    {
        $user = new Users();
        $form = $this->createForm(RegistrationFormType::class, $user);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            /** @var string $plainPassword */
            $plainPassword = $form->get('plainPassword')->getData();

            // encode the plain password
            $user->setPassword($userPasswordHasher->hashPassword($user, $plainPassword));

            $entityManager->persist($user);
            $entityManager->flush();

            // Connecte l'utilisateur après l'enregistrement
            $security->login($user);

            return $this->redirectToRoute('app_home');
        }

        return $this->render('registration/register.html.twig', [
            'registrationForm' => $form,
        ]);
    }

    #[Route('/mon-compte/supprimer', name: 'app_user_delete', methods: ['GET', 'POST'])]
    #[IsGranted('ROLE_USER')]
    public function deleteAccount(Request $request, EntityManagerInterface $entityManager, Security $security): Response
    {
        /** @var Users $user */
        $user = $security->getUser();

        // Si l'utilisateur n'est pas connecté ou est null, on le redirige
        if (!$user) {
            return $this->redirectToRoute('app_login');
        }

        // On gère la suppression si la méthode est POST
        if ($request->isMethod('POST')) {
            // Vérifie le jeton CSRF pour la sécurité
            if ($this->isCsrfTokenValid('delete-account-' . $user->getId(), $request->request->get('_token'))) {
                $entityManager->remove($user);
                $entityManager->flush();

                // Déconnecte l'utilisateur après la suppression
                $security->logout(false);

                $this->addFlash('success', 'Votre compte a bien été supprimé.');
                return $this->redirectToRoute('app_home');
            }
        }

        // Chemin mis à jour vers le nouveau template
        return $this->render('profile/deletedAccount.html.twig', [
            'user' => $user,
        ]);
    }
}