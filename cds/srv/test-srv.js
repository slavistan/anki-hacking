module.exports = function(srv) {
    /* Echo message */
    srv.on ('echo', req => `${req.data.msg}`)

    /* Print server time */
    srv.on ('srvtime', req => {
        /* Returns Edm.DateTimeOffset */
        var x = new Date().toISOString()
        return x
    })

    srv.on ('timetostring', req => {
        // var x = new Date(req.data.thedate)
        // console.log(x)
        return 'hi'
    })
}