<?php

namespace app\controller;

use support\Request;

class InfoController
{
    public function index(Request $request)
    {
        ob_start();
        phpinfo();
        $phpinfo = ob_get_contents();
        ob_end_clean();
        return sprintf("<pre>%s</pre>",$phpinfo);
    }
}
