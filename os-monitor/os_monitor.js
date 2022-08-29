const osu = require('./node-os-utils')
const EventEmitter = require('events')
const cpu = osu.cpu
const drive = osu.drive
const mem = osu.mem

module.exports = class OSMonitor extends EventEmitter {

  constructor ( ) {
     super()
     this.cpu = osu.cpu
     this.drive = osu.drive
     this.mem = osu.mem
  }

  serializeData ( id_atribute, value )  {
    const payload = {
      id_atribute,
      value
    }
    return payload
  }

  ingestData ( type, measurement )  {

    let payload;

    switch ( type ) {
      case 'cpu':
        payload = this.serializeData('cpu_usage', measurement)
        this.emit('measurement', payload)
        break;
      case 'drive':
        payload = this.serializeData('drive_usage', measurement.usedPercentage)
        this.emit('measurement', payload)
        break;
      case 'mem':
        const memUsage = 100 - measurement.freeMemPercentage
        payload = this.serializeData('mem_usage', memUsage)
        this.emit('measurement', payload)
        break;
      default:
        break;
    }
  }

  start() {
    const interval = 10000
    console.log('start');

    setInterval(() => {
      this.cpu.usage()
        .then( cpuPercentage => {
          this.ingestData('cpu', cpuPercentage)
        })
        .catch((err) => {
          console.log('error cpu', err);
        })
      this.drive.info()
        .then( driveInfo => {
          this.ingestData('drive', driveInfo)
        })
        .catch((err) => {
          console.log('error drive', err);
        })
      this.mem.info()
        .then( memInfo => {
          this.ingestData('mem', memInfo)
        })
        .catch((err) => {
          console.log('error mem', err);
        })
    }, interval)
  }
}
