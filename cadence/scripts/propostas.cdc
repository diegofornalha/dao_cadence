import DAO from 0x05
pub fun main(proposalID: UInt32): DAO.Proposal? {
    // Consulte o estado atual do contrato DAO para obter informações sobre a proposta
    let proposal: DAO.Proposal? = DAO.proposals[proposalID]
    
    // Retorna a proposta ou nulo se não existir
    return proposal
}
