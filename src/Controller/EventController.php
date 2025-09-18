<?php

namespace App\Controller;

use App\Entity\Events;
use App\Entity\Registrations;
use App\Repository\EventsRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\String\Slugger\SluggerInterface;
use Symfony\Component\HttpFoundation\File\UploadedFile;
use Symfony\Component\HttpFoundation\File\Exception\FileException;
use Doctrine\ORM\EntityManagerInterface;

class EventController extends AbstractController
{
    #[Route('/event/new', name: 'app_create_event')]
    public function new(Request $request, EventsRepository $eventsRepository, SluggerInterface $slugger, EntityManagerInterface $entityManager): Response
    {
        if ($request->isMethod('POST')) {
            $event = new Events();

            $event->setTitle($request->request->get('title'));
            $event->setDescription($request->request->get('description'));
            $event->setCreatedBy($this->getUser());
            $event->setLocation($request->request->get('location'));
            $event->setCapacity((int)$request->request->get('capacity'));
            $event->setStartDate(new \DateTimeImmutable($request->request->get('start_date')));
            $event->setEndDate(new \DateTimeImmutable($request->request->get('end_date')));
            $event->setIsPublic($request->request->has('is_public'));
            $event->setRegisteredCount(0);

            /** @var UploadedFile $imageFile */
            $imageFile = $request->files->get('image');

            if (!$imageFile || !$imageFile->isValid()) {
                $this->addFlash('error', 'L\'image est obligatoire et doit être valide.');
                return $this->redirectToRoute('app_create_event');
            }

            $originalFilename = pathinfo($imageFile->getClientOriginalName(), PATHINFO_FILENAME);
            $safeFilename = $slugger->slug($originalFilename);
            $extension = $imageFile->guessExtension() ?? 'bin';
            $newFilename = $safeFilename.'-'.uniqid().'.'.$extension;

            try {
                $imageFile->move(
                    $this->getParameter('kernel.project_dir').'/public/uploads/events',
                    $newFilename
                );
                $event->setImage('/uploads/events/'.$newFilename);
            } catch (FileException $e) {
                $this->addFlash('error', 'Une erreur est survenue lors du téléchargement de l\'image.');
                return $this->redirectToRoute('app_create_event');
            }

            $entityManager->persist($event);
            $entityManager->flush();

            return $this->redirectToRoute('app_home', [], Response::HTTP_SEE_OTHER);
        }

        return $this->render('event/createEvent.html.twig', [
            'controller_name' => 'EventController',
        ]);
    }

    // Voir + d'infos sur un event
    #[Route('/event/{id}', name: 'app_event_show')]
    public function show(Events $event, EntityManagerInterface $entityManager): Response
    {
        $user = $this->getUser();
        $isRegistered = false;

        if ($user) {
            $registration = $entityManager->getRepository(Registrations::class)->findOneBy([
                // ici on utilise les noms des propriétés de ton entité Registrations
                'user_id' => $user,
                'event_id' => $event,
            ]);
            $isRegistered = $registration !== null;
        }

        // On récupère explicitement les inscriptions via le repository (évite getRegistrations() si mapping cassé)
        $registrations = $entityManager->getRepository(Registrations::class)->findBy([
            'event_id' => $event,
        ]);

        return $this->render('event/showEvent.html.twig', [
            'event' => $event,
            'registrations' => $registrations,
            'isRegistered' => $isRegistered,
        ]);
    }

    // Rejoindre un event
    #[Route('/event/{id}/join', name: 'app_event_join', methods: ['GET','POST'])]
    public function join(Events $event, EntityManagerInterface $entityManager): Response
    {
        $user = $this->getUser();

        if (!$user) {
            $this->addFlash('error', 'Vous devez être connecté pour vous inscrire à un événement.');
            return $this->redirectToRoute('app_login');
        }

        $existingRegistration = $entityManager->getRepository(Registrations::class)->findOneBy([
            'user_id' => $user,
            'event_id' => $event,
        ]);

        if ($existingRegistration) {
            $this->addFlash('info', 'Vous êtes déjà inscrit à cet événement.');
            return $this->redirectToRoute('app_event_show', ['id' => $event->getId()]);
        }

        $registration = new Registrations();
        $registration->setUserId($user);
        $registration->setEventId($event);
        $registration->setRegisteredAt(new \DateTimeImmutable());

        $entityManager->persist($registration);

        // Mettre à jour le compteur (optionnel)
        $current = $event->getRegisteredCount() ?? 0;
        $event->setRegisteredCount($current + 1);
        $entityManager->persist($event);

        $entityManager->flush();

        $this->addFlash('success', 'Vous avez rejoint l\'événement avec succès !');

        return $this->redirectToRoute('app_event_show', ['id' => $event->getId()]);
    }

    // Quitter un event (se désinscrire)
    #[Route('/event/{id}/quit', name: 'app_event_quit', methods: ['GET','POST'])]
    public function quit(Events $event, EntityManagerInterface $entityManager): Response
    {
        $user = $this->getUser();

        if (!$user) {
            $this->addFlash('error', 'Vous devez être connecté pour vous désinscrire d\'un événement.');
            return $this->redirectToRoute('app_login');
        }

        $registration = $entityManager->getRepository(Registrations::class)->findOneBy([
            'user_id' => $user,
            'event_id' => $event,
        ]);

        if ($registration) {
            $entityManager->remove($registration);

            $current = $event->getRegisteredCount() ?? 0;
            $event->setRegisteredCount(max(0, $current - 1));
            $entityManager->persist($event);

            $entityManager->flush();

            $this->addFlash('success', 'Vous vous êtes désinscrit de l\'événement.');
        } else {
            $this->addFlash('info', 'Vous n\'êtes pas inscrit à cet événement.');
        }

        return $this->redirectToRoute('app_event_show', ['id' => $event->getId()]);
    }

    // Modifier un event
#[Route('/event/{id}/edit', name: 'app_event_edit')]
public function edit(Request $request, Events $event, SluggerInterface $slugger, EntityManagerInterface $entityManager): Response
{
    if ($request->isMethod('POST')) {
        $event->setTitle($request->request->get('title'));
        $event->setDescription($request->request->get('description'));
        $event->setLocation($request->request->get('location'));
        $event->setCapacity((int)$request->request->get('capacity'));
        $event->setStartDate(new \DateTimeImmutable($request->request->get('start_date')));
        $event->setEndDate(new \DateTimeImmutable($request->request->get('end_date')));
        $event->setIsPublic($request->request->has('is_public'));

        /** @var UploadedFile $imageFile */
        $imageFile = $request->files->get('image');

        if ($imageFile && $imageFile->isValid()) {
            $originalFilename = pathinfo($imageFile->getClientOriginalName(), PATHINFO_FILENAME);
            $safeFilename = $slugger->slug($originalFilename);
            $extension = $imageFile->guessExtension() ?? 'bin';
            $newFilename = $safeFilename.'-'.uniqid().'.'.$extension;

            try {
                $imageFile->move(
                    $this->getParameter('kernel.project_dir').'/public/uploads/events',
                    $newFilename
                );
                $event->setImage('/uploads/events/'.$newFilename);
            } catch (FileException $e) {
                $this->addFlash('error', 'Une erreur est survenue lors du téléchargement de l\'image.');
                return $this->redirectToRoute('app_event_edit', ['id' => $event->getId()]);
            }
        }
        // Si aucune nouvelle image, on garde l'ancienne valeur

        $entityManager->persist($event);
        $entityManager->flush();

        $this->addFlash('success', 'Événement mis à jour avec succès !');
        return $this->redirectToRoute('app_event_show', ['id' => $event->getId()]);
    }

    return $this->render('event/editEvent.html.twig', [
        'event' => $event,
    ]);
}

    
    // Supprimer un event
    #[Route('/event/{id}/delete', name: 'app_event_delete', methods: ['POST'])]
    public function delete(Request $request, Events $event, EntityManagerInterface $entityManager): Response
    {
        $user = $this->getUser();
        if (!$user || ($event->getCreatedBy() !== $user && !in_array('ROLE_ADMIN', $user->getRoles()))) {
            $this->addFlash('error', 'Vous n\'avez pas la permission de supprimer cet événement.');
            return $this->redirectToRoute('app_event_show', ['id' => $event->getId()]);
        }

        if ($this->isCsrfTokenValid('delete'.$event->getId(), $request->request->get('_token'))) {
            $entityManager->remove($event);
            $entityManager->flush();
            $this->addFlash('success', 'L\'événement a été supprimé avec succès.');
        } else {
            $this->addFlash('error', 'Jeton CSRF invalide. L\'événement n\'a pas été supprimé.');
        }

        return $this->redirectToRoute('app_home');
    }
}
