module.exports = async (srv) => {

    srv.after ('CREATE', 'Cards', async (req) => {

        console.log("Created card:", req.ID)
        
         // await cds.connect.to('db')
         const { Cards } = cds.entities;
         console.log(await cds.read(Cards))
    })

}