<?php

namespace App\Controller;

use App\Entity\Events;
use App\Repository\EventsRepository;
use Knp\Component\Pager\PaginatorInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class HomeController extends AbstractController
{
    #[Route('/', name: 'app_home')]
    public function index(Request $request, EventsRepository $eventsRepository, PaginatorInterface $paginator): Response
    {
        // On récupère le terme de recherche depuis l'URL
        $searchQuery = $request->query->get('search');
        
        // On crée la requête pour les événements publics
        $queryBuilder = $eventsRepository->createQueryBuilder('e')
            ->where('e.is_public = :is_public')
            ->setParameter('is_public', true)
            ->orderBy('e.start_date', 'DESC');

        // Si un terme de recherche est présent, on filtre les résultats
        if ($searchQuery) {
            $queryBuilder
                ->andWhere('e.title LIKE :search OR e.description LIKE :search OR e.location LIKE :search')
                ->setParameter('search', '%' . $searchQuery . '%');
        }

        // On utilise le service de pagination
        $events = $paginator->paginate(
            $queryBuilder->getQuery(),
            $request->query->getInt('page', 1),
            9
        );

        return $this->render('home/index.html.twig', [
            'events' => $events,
        ]);
    }
}