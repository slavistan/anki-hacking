module.exports = srv => {

    // console.log('Service name:', srv.name, ' at ', srv.path)

    srv.after ('READ', 'Cards', cards => {
        console.log('After-Read');
        cards.forEach(x => { console.log(x.command) })
    })
}