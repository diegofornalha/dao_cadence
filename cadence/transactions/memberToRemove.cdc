import DAO from 0x05 // Substitua 0x05 pelo endereço real do contrato DAO

transaction(memberToRemove: Address) {
    prepare(signer: AuthAccount) {
        // Verifique se o executor da transação é o criador do contrato
        assert(DAO.creator == signer.address, message: "Apenas o criador pode remover membros")

        // Execute a função `removeMember` do contrato DAO para remover o membro
        DAO.removeMember(address: memberToRemove)

        // Log para indicar que o membro foi removido com sucesso
        log("Membro removido com sucesso!")
    }
}
