<?php

namespace App\Controller;

use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpKernel\Attribute\AsController;
use Symfony\Component\Routing\Attribute\Route;

#[AsController]
class InfoController
{
    #[Route('/info', name: 'phpinfo')]
    public function __invoke(): Response
    {
        ob_start();
        phpinfo();
        $phpinfo = ob_get_contents();
        ob_end_clean();
        return new Response(sprintf("<pre>%s</pre>",$phpinfo));
    }
}
