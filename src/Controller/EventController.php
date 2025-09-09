<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class EventController extends AbstractController
{
    #[Route('/event/new', name: 'app_create_event')]
    public function new(): Response
    {
        return $this->render('event/createEvent.html.twig');
    }
}
