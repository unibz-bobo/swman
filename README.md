# swman
Generic software package manager script. It can be used on Linux 
distributions like Debian and Arch Linux. Simply clone this repository 
and use it in your scripts.

## Examples

`./swman -a <service-names>` to start services.

`./swman -o <service-names>` to stop services.

`./swman -z <service-names>` to restart services.

`./swman -s <service-names>` to query the status of services.

`./swman -u` to update and upgrade existing software packages.

`./swman -i <package-names>` to install new packages, existing packages 
will be ignored.

`./swman -r <package-names>` to remove installed packages.
