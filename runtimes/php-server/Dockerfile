FROM scratch
COPY php /bin/php
COPY index.php /var/www/index.php

ENTRYPOINT ["/bin/php", "-S", "0.0.0.0:8080", "/var/www/index.php"]
