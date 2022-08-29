const mqtt = require('mqtt')

module.exports = class MqttTransport extends Agent {

  constructor ( config ) {
    super ( config )
    this.host = config.host
    this.port = config.port
    this.client = {}
    this.clientId = config.client.clientId
    this.password = config.client.password
    this.topics = config.topics
  }

  async connect (  ) {
    this.client = mqtt.connect(`mqtt://${this.host}:${this.port}`,{
      clientId: this.clientId,
      username: this.clientId,
      password: this.password,
      reconnectPeriod: 10000,
    })
  }

  async start () {
    try {
      this.connect()
      this.mqttEvents()
      await this.subscribe ( this.topics )
    } catch (e) {
      throw e
    }
  }

  mqttEvents () {

    /*
    *  Client Events
    */

    this.client.on('connect', (connack) => {
      console.log('MQTT ==> Cliente Conectado');
      this.status = 'online'
    })

    this.client.on('reconnect', () => {
      console.log('MQTT ==> Reconectando');
    })

    this.client.on('offline', () => {
      this.status = 'offline'
      console.log('MQTT ==> offline');
    })

    this.client.on('error', (error) => {
      this.status = 'offline'
      console.log('MQTT ==> Error Conexión.');
    })

    this.client.on('close', () => {
      this.status = 'offline'
      console.log('MQTT ==> Close');
    })

    /*
    *  Message Event
    */

    this.client.on('message', (topic, message, packet) => {
      /* console.log('MQTT ==> New Message');
      * console.log('packet', packet);
      console.log('MQTT ==> Topic:', topic);
      console.log('MQTT ==> Message:', message.toString());
      */
      this.emit ( `${this.name}/message`, { topic, payload: toJSON(message), packet } )
    })
    /*
    this.client.on('packetsend', (packet) => {
      console.log('MQTT ==> Message Send');
      console.log('MQTT ==> Packet:', packet);
    })

    this.client.on('packetreceive', (packet) => {
      console.log('MQTT ==> Message Receive');
      console.log('MQTT ==> Packet:', packet);
    })
    */
  }

  async connectClient ( client ) {
    console.log('connectClient', client);
    const device = {
      id: client.id,
      transport: this.transport
    }

    try {
      const device = await updateDevice( device )

      if ( device ) {
        this.emit(`${this.name}/connectClient`, client)
      }
      else {
        /*
        *  Quizas desconectar el cliente
        */
        console.log(`Agent ${this.name} ==> Dispositivo no encontrado`)
      }
    } catch (e) {
      throw new Error(e)
    }

  }

  disconnectClient ( client ) {
    this.emit(`${this.name}/disconnectClient`, client)
  }

  publish ( topic, message, options ) {
    return new new Promise((resolve, reject) => {
      this.client.publish( topic, message, options, (err) => {
        if ( err ){
          reject (err)
        }
        else {
          resolve ()
        }
      })
    });
  }

  subscribe ( topics, options ) {
    return new Promise((resolve, reject) => {
      if ( this.status ) {
        this.client.subscribe( topics, options, (err) => {
          if(err){
            reject (err)
          }
          else {
            resolve ()
          }
        })
      }
      else {
        reject('MQTT ==> MQTT OFFLINE')
      }
    });
  }

}
