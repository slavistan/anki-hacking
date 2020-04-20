module.exports = srv => {

    srv.after ('READ', 'Cards', cards => {
        console.log(cards.data);
    })
    
    srv.after ('CREATE', 'Cards', card => {
        /* Schedule card */
        console.log('Created card: ', card.ID);

        // Connect to database & schedule
    })

}