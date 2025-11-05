<?php

namespace app\controller;

use support\Request;

class IndexController
{
    public function index(Request $request)
    {
        return "Hello world!";
    }

    public function info(Request $request)
    {
        ob_start();
        phpinfo();
        $phpinfo = ob_get_contents();
        ob_end_clean();
        return $phpinfo;
    }
}
