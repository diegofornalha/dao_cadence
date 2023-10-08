import DAO from 0x05

transaction(description: String) {
    prepare(signer: AuthAccount) {
        // Verifique se o executor da transação é um membro do DAO
        if let member = DAO.members[signer.address] {
            // Execute a função `createProposal` do contrato DAO para criar uma nova proposta
            DAO.createProposal(description: description)

            // Log para indicar que a proposta foi criada com sucesso
            log("Proposta criada com sucesso!")
        } else {
            // Se o executor não for um membro, emita um erro
            panic("Apenas membros podem criar propostas")
        }
    }
}
