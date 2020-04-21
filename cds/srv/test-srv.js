module.exports = function(srv) {
    /* Echo message */
    srv.on ('echo', req => `${req.data.msg}`)

    /* Print server time */
    srv.on ('srvtime', req => {
        /* Returns Edm.DateTimeOffset */
        var x = new Date().toISOString()
        return x
    })

    srv.on ('timetostring', async (req) => {
        // var x = new Date(req.data.thedate)
        // console.log(x)
        return 'hi'
    })

    srv.on ('foo', async (req) => {
        await cds.connect.to('db')
        const { Cards } = cds.entities;
        tx = cds.transaction()
        console.log(await tx.read(Cards))
        
        return 'Snafu'
    })
}