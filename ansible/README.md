# Virtual Boost Ansible Playbooks


## Hosts Inventory

* El inventario de hosts está ubicado en `/etc/ansible/hosts`.
* `ansible-playbook` tiene la opción `-i` para seleccionar otra ruta de inventario.
* *Copia de inventario en Bitwarden*

### Test Hosts Inventory

`ANSIBLE_HOST_KEY_CHECKING=False ansible lab -i hosts -m ping`

*ANSIBLE_HOST_KEY_CHECKING=False deshabilita el checkeo de claves ssh*


## Hosts Minimal configuration

* Los hosts deben tener en el usuario root la clave pública ssh desde donde ansible se conectará
* Cuando el usuario x defecto no sea root, este deberá tener permisos para ser super usuario sin contraseña, de lo contrario se tendrá que ingresar una contraseña con la opción -K
