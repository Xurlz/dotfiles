phpWithXdebug() { php -dxdebug.mode=debug -dxdebug.start_with_request=yes $@ ; }

export -f phpWithXdebug
