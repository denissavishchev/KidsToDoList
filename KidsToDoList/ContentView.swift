import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Environment(\.modelContext) var mc
    @Query var tasks: [Task]
    @State private var path = [Task]()
    
    var body: some View {
        NavigationStack(){
            NavigationLink(destination: AddTaskView()){
                Text("Add task")
            }
            List{
                ForEach(tasks){task in
                        VStack(alignment: .leading){
                            Text(task.name)
                                .font(.headline)
                            Text(task.deadline.formatted(date: .long, time: .shortened))
                        }
                }
                .onDelete(perform: deleteTask)
            }
        }
    }
    
    func deleteTask(_ indexSet: IndexSet){
        for index in indexSet{
            let task = tasks[index]
            mc.delete(task)
        }
    }
    
}

#Preview {
    ContentView()
}
