import DAO from 0x05

pub fun main(proposalID: UInt32): UFix64? {
    // Consulte o estado atual do contrato DAO para obter informações sobre a proposta
    let proposal: DAO.Proposal? = DAO.proposals[proposalID]
    
    // Verifique se a proposta existe
    if let existingProposal = proposal {
        // Calcule o total de votos para a proposta
        var totalVotes: UFix64 = 0.0
        for vote in existingProposal.votes.values {
            totalVotes = totalVotes + vote
        }
        
        // Retorna o total de votos para a proposta
        return totalVotes
    } else {
        // Se a proposta não existir, retorne nil (nulo)
        return nil
    }
}
