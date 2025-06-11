import SwiftUI

struct MessageListView: View {
    @StateObject private var viewModel = MessageViewModel()

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                }

                if let error = viewModel.errorMessage {
                    VStack {
                        Text(error)
                            .foregroundColor(.red)
                        Button("Retry") {
                            viewModel.fetch()
                        }
                        .padding(.top, 4)
                    }
                }

                List(viewModel.messages) { message in
                    HStack(spacing: 15) {
                        AsyncImage(url: message.imageURL) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                            case .success(let image):
                                image
                                    .resizable()
                                    .frame(width: 60, height: 60)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            case .failure:
                                Image(systemName: "photo")
                                    .resizable()
                                    .frame(width: 60, height: 60)
                                    .foregroundColor(.gray)
                            @unknown default:
                                EmptyView()
                            }
                        }

                        Text(message.title)
                            .font(.body)
                            .lineLimit(2)
                            .transition(.slide)
                    }
                    .padding(.vertical, 5)
                }
                .animation(.easeInOut, value: viewModel.messages)


                HStack {
                    Button("Fetch (Async)") {
                        viewModel.fetch(usingCombine: false)
                    }
                    .buttonStyle(.borderedProminent)

                    Button("Fetch (Combine)") {
                        viewModel.fetch(usingCombine: true)
                    }
                    .buttonStyle(.bordered)

                    Button("Cancel") {
                        viewModel.cancelFetch()
                    }
                    .buttonStyle(.bordered)

                }
                .padding()
            }
            .navigationTitle("Messages")
        }
    }
}

#Preview {
    MessageListView()
}
