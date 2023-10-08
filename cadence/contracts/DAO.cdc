pub contract DAO {
    // Estrutura para representar um membro
    pub struct Member {
        pub var address: Address
        pub var isMember: Bool

        init(address: Address) {
            self.address = address
            self.isMember = true
        }
    }

    // Estrutura para representar uma proposta
    pub struct Proposal {
        pub var id: UInt32
        pub var description: String
        pub var votes: {Address: UFix64}
        pub var totalVotes: UFix64
        pub(set) var executed: Bool

        init(id: UInt32, description: String) {
            self.id = id
            self.description = description
            self.votes = {}
            self.totalVotes = 0.0
            self.executed = false
        }

        // Função para adicionar votos à proposta
            pub fun addVote(address: Address, tokens: UFix64) {
            self.votes[address] = tokens
            self.totalVotes = self.totalVotes + tokens
        }

    }

    // Endereço do criador do DAO
    pub let creator: Address

    // Lista de membros
    pub var members: {Address: Member}

    // Lista de propostas
    pub var proposals: {UInt32: Proposal}

    // ID da próxima proposta
    pub var nextProposalID: UInt32

    // Inicializador do contrato DAO
    init() {
        self.members = {}
        self.proposals = {}
        self.nextProposalID = 1
        self.creator = self.account.address
    }

    // Adicionar um membro ao DAO
    pub fun addMember(address: Address) {
        // Verificar se o chamador é o criador do DAO
        if self.creator != self.account.address {
            panic("Apenas o criador do DAO pode adicionar membros")
        }

        // Verificar se o membro já está na lista
        if self.members[address] != nil {
            panic("O membro já está na lista")
        }

        // Adicionar o membro à lista
        self.members[address] = Member(address: address)
    }

    // Remover um membro do DAO
    pub fun removeMember(address: Address) {
        // Verificar se o chamador é o criador do DAO
        if self.creator != self.account.address {
            panic("Apenas o criador do DAO pode remover membros")
        }

        // Verificar se o membro está na lista
        if let member = self.members[address] {
            // Remover o membro da lista
            self.members[address] = nil
        } else {
            panic("O membro não está na lista")
        }
    }

    // Criar uma proposta
    pub fun createProposal(description: String) {
        // Verificar se o chamador é um membro
        if let member = self.members[self.account.address] {
            // Criar uma nova proposta
            let proposal = Proposal(
                id: self.nextProposalID,
                description: description
            )

            // Adicionar a proposta à lista
            self.proposals[self.nextProposalID] = proposal

            // Incrementar o ID da próxima proposta
            self.nextProposalID = self.nextProposalID + 1
        } else {
            panic("Apenas membros podem criar propostas")
        }
    }

    // Votar em uma proposta
    pub fun vote(proposalID: UInt32, tokens: UFix64) {
        // Verificar se o chamador é um membro
        if let member = self.members[self.account.address] {
            // Verificar se a proposta existe
            if let proposal = self.proposals[proposalID] {
                // Verificar se a proposta não foi executada
                if !proposal.executed {
                    // Adicionar os votos do membro à proposta
                    proposal.addVote(address: self.account.address, tokens: tokens)
                } else {
                    panic("A proposta já foi executada")
                }
            } else {
                panic("Proposta não encontrada")
            }
        } else {
            panic("Apenas membros podem votar")
        }
    }

    // Executar uma proposta
    pub fun executeProposal(proposalID: UInt32) {
        // Verificar se o chamador é o criador do DAO
        if self.creator != self.account.address {
            panic("Apenas o criador do DAO pode executar propostas")
        }

        // Verificar se a proposta existe
        if let proposal = self.proposals[proposalID] {
            // Verificar se a proposta não foi executada
            if !proposal.executed {
                // Verificar se a quantidade total de votos é maior ou igual à quantidade de tokens necessária
                if proposal.totalVotes >= 0.5 {
                    // Executar a proposta (coloque a lógica da proposta aqui)

                    // Marcar a proposta como executada
                    proposal.executed = true
                } else {
                    panic("A quantidade total de votos não atingiu o limite necessário")
                }
            } else {
                panic("A proposta já foi executada")
            }
        } else {
            panic("Proposta não encontrada")
        }
    }
}
