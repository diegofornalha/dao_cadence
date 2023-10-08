import DAO from 0x05
transaction(proposalID: UInt32, tokens: UFix64) {
    prepare(signer: AuthAccount) {
        // Verifique se o executor da transação é um membro do DAO
        if let member = DAO.members[signer.address] {
            // Execute a função `vote` do contrato DAO para votar em uma proposta
            DAO.vote(proposalID: proposalID, tokens: tokens)

            // Log para indicar que o voto foi registrado com sucesso
            log("Voto registrado com sucesso!")
        } else {
            // Se o executor não for um membro, emita um erro
            panic("Apenas membros podem votar")
        }
    }
}
