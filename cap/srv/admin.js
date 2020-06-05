module.exports = async (srv) => {

    const { ContentBasic, Cards } = cds.entities;

    /*
     * Create a corresponding card.
     *
     * Cards are created via POST to the ContentBasic endpoint. The autogen'd
     * UUID is used to create a new record in the `Cards' table with the
     * corresponding card type and the defaults set in the schema.
     *
     * TODO: Why does the code below not work with the on-handler (srv.on(...))?
     */
    srv.before('CREATE', 'ContentBasic', async (req) => {
        const tx = cds.transaction(req)
        const query = INSERT.into(Cards).columns(['ID', 'type']).values([req.data.card_ID, "Basic"])
        await tx.run(query)
    })
}