import DAO from 0x05

transaction(proposalID: UInt32) {
    prepare(signer: AuthAccount) {
        // Verifique se o executor da transação é o criador do DAO
        assert(DAO.creator == signer.address, message: "Apenas o criador pode executar propostas")

        // Execute a função `executeProposal` do contrato DAO para executar a proposta
        DAO.executeProposal(proposalID: proposalID)

        // Log para indicar que a proposta foi executada com sucesso
        log("Proposta executada com sucesso!")
    }
}
