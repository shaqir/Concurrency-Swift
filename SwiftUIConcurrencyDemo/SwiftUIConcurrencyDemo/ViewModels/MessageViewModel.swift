import Foundation
import Combine

@MainActor
class MessageViewModel: ObservableObject {
    @Published var messages: [Message] = []
    @Published var isLoading = false
    @Published var errorMessage: String? = nil

    var cancellables = Set<AnyCancellable>()
    private var fetchTask: Task<Void, Never>? = nil

    init() {
        // Load cache on launch
        self.messages = NetworkService.loadFromCache()
    }

    func fetch(usingCombine: Bool = false) {
            isLoading = true
            errorMessage = nil

            if usingCombine {
                NetworkService.fetchMessagesPublisher()
                    .receive(on: DispatchQueue.main)
                    .sink { [weak self] completion in
                        self?.isLoading = false
                        if case .failure(_) = completion {
                            self?.errorMessage = "Combine fetch failed"
                        }
                    } receiveValue: { [weak self] messages in
                        self?.messages = messages
                    }
                    .store(in: &cancellables)
            } else {
                fetchTask?.cancel()
                fetchTask = Task {
                    do {
                        let result = try await NetworkService.fetchMessages()
                        self.messages = result
                    } catch {
                        self.errorMessage = "Async fetch failed"
                    }
                    self.isLoading = false
                }
            }
        }


    func cancelFetch() {
        fetchTask?.cancel()
        isLoading = false
        cancellables.removeAll()
    }
}
