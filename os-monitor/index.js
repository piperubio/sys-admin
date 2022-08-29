const OSMonitor = require('./os_monitor')

const osMonitor = new OSMonitor()

osMonitor.start()

osMonitor.on('measurement', ( data ) => {
  console.log('data', data);
})
