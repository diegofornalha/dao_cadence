import DAO from 0x05

transaction(newMemberAddress: Address) {
    // Verifique se o executor da transação é o criador do contrato
    prepare(admin: AuthAccount) {
        assert(DAO.creator == admin.address, message: "Apenas o criador pode adicionar membros")
    }

    // Adicione o novo membro
    execute {
    DAO.addMember(address: newMemberAddress)
        log("Membro adicionado com sucesso!")
    }
}
