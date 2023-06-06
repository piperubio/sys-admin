# Debian Ansible


## Hosts Inventory

* El inventario de hosts está ubicado en `/etc/ansible/hosts`.
* `ansible-playbook` tiene la opción `-i` para seleccionar otra ruta de inventario.

## Estructura de un Inventory

```yaml
[grupo_de_hosts]
host1 ansible_user=usuario1
host2 ansible_user=usuario2
host3 ansible_user=usuario3

```

### Estrategias de configuración inicial para los hosts

Esta guía proporcionará una visión general de varias estrategias para configurar hosts iniciales para ser administrados por Ansible. Cubriremos varios métodos de autenticación y escalado de privilegios.

## Autenticación como Root

### 1. Autenticación de Clave Pública

Para usar la autenticación de clave pública con el usuario root, primero debes generar o reutilizar una clave SSH en la máquina desde la cual Ansible se conectará al host. Luego, debes copiar la clave pública al host en el archivo `~/.ssh/authorized_keys` del usuario root. Aquí están los pasos:

1. Generar la clave SSH (en el caso de que no tengas una):

   ```bash
   ssh-keygen
   ```

2. Copiar la clave al host remoto:

   ```bash
   ssh-copy-id root@host_remoto
   ```

En tu archivo de inventario de Ansible, debes especificar el usuario root:

```ini
[nombre_del_grupo]
nombre_del_host ansible_user=root
```

### 2. Autenticación por Contraseña

Para usar la autenticación por contraseña con el usuario root, simplemente debes especificar la opción `--ask-pass` o `-k` al ejecutar el playbook de Ansible. Sin embargo, este método no se recomienda para uso a largo plazo debido a problemas de seguridad.

```bash
ansible-playbook playbook.yml --ask-pass
```

## Autenticación como Usuario No Root con Escalado de Privilegios

### 1. Autenticación de Clave Pública con Escalado a Root

El proceso para configurar la autenticación de clave pública para un usuario no root es similar al del usuario root. La única diferencia es que, además, debes configurar `sudo` para permitir al usuario ejecutar comandos como root sin necesidad de una contraseña. Aquí están los pasos:

1. Configura la autenticación de clave pública como se describió anteriormente.

2. En el host remoto, ejecuta `visudo` y agrega la siguiente línea, reemplazando `nombre_de_usuario` con el nombre del usuario que estás configurando:

   ```bash
   nombre_de_usuario ALL=(ALL) NOPASSWD:ALL
   ```

3. En tu archivo de inventario de Ansible, especifica el usuario no root y habilita el escalado de privilegios:

   ```ini
   [nombre_del_grupo]
   nombre_del_host ansible_user=nombre_de_usuario ansible_become=true
   ```

### 2. Autenticación por Contraseña con Escalado a Root

Para usar la autenticación por contraseña con un usuario no root y escalado a root, debes especificar tanto `--ask-pass` como `--ask-become-pass` (o `-K`) al ejecutar el playbook de Ansible.

```bash
ansible-playbook playbook.yml --ask-pass --ask-become-pass
```

## Estrategias Adicionales

Las estrategias mencionadas son las más comunes y generalmente suficientes para la mayoría de los casos. Sin embargo, Ansible es altamente configurable y puedes ajustar la configuración para satisfacer tus necesidades específicas. Algunas estrategias adicionales que podrías considerar incluyen:

- Autenticación por clave pública con un agente SSH para gestionar las claves.
- Autenticación mediante Kerberos o LDAP si tienes un directorio activo o un sistema de autenticación central



### Test Hosts Inventory

`ANSIBLE_HOST_KEY_CHECKING=False ansible -i hosts -m ping NOMBRE_GRUPO`

*ANSIBLE_HOST_KEY_CHECKING=False deshabilita el checkeo de claves ssh*

## Instalar dependencias (Colecciones,roles)

```bash
$ ansible-galaxy install -r requirements.yml
```

o

```bash
$ ansible-galaxy install NOMBRE_COLECCIÓN|NOMBRE_ROL
```

## Playbooks

### Opciones

* `--inventory`, `-i` para especificar el inventario de hosts
* `--limit`, `-l` para limitar el playbook a un grupo de hosts
* `--syntax-check` para probar la sintaxis del playbook
* `--check`, `-C` para probar el playbook sin aplicar cambios
* `--ask-become-pass`, `-K` para ingresar la contraseña de sudo
* `--list-hosts` para listar los hosts que se verán afectados por el playbook
* `--list-tags` para listar los tags del playbook
* `--list-tasks` para listar las tareas del playbook
* `--start-at-task` para iniciar el playbook desde una tarea en particular
* `--step` para ejecutar el playbook en modo interactivo
* `--tags`, `-t` para ejecutar solo las tareas con el tag especificado
* `--skip-tags` para saltar las tareas con el tag especificado
* `--become-user` para especificar el usuario con el que se ejecutarán las tareas



### Probar Sintaxis

```bash
$ ansible-playbook --syntax-check tu_playbook.yaml
```

### Probar playbook

```bash
$ ansible-playbook --check tu_playbook.yaml
```

### Aplicar playbook

```bash
$ ansible-playbook --apply main.yml
```

