1. Extender el disco en el proveedor cloud o máquina virtual.

2. Puedes listar los discos con `lsblk` o `fdisk -l`

3. En el servidor ejecutar
    ``` fdisk -l ```
     y buscar el disco extendido.

2.a Si el disco no refleja los cambios ejecutar
``` ls /sys/class/scsi_device/ ```
y por cada dispositivo ejecutar
``` echo 1 > /sys/class/scsi_device/XXXXXXX/device/rescan ```
Esto permitirá que el SO lea otra vez los discos.

3. Extender el volument físico ejecutando  ``` pvresize /dev/sdx ``` con el disco a trabajar. Comprobar los cambios ejecutando ``` pvs ```
 
4. Extender el volumen de grupo y lógico ejecutando ``` lvextend -r -l +100%FREE /dev/mapper/XXXXXXXX ``` (en caso de problemas con la opción -r ejecutar ``` resize2fs /dev/mapper/vg--elastic-lv--elastic ``` luego de extender el volumen) con el grupo a trabajar. Comprobar los cambios ejecutando ``` pvs ```,  ``` vgs ```, ``` lvs ``` y ``` df -h```.

