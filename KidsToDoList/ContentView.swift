import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Environment(\.modelContext) var mc
    @Query var tasks: [Task]
    @State private var path = [Task]()
    
    var body: some View {
        NavigationStack(path: $path){
            List{
                ForEach(tasks){task in
                    NavigationLink(value: task){
                        VStack(alignment: .leading){
                            Text(task.name)
                                .font(.headline)
                            Text(task.deadline.formatted(date: .long, time: .shortened))
                        }
                    }
                }
                .onDelete(perform: deleteTask)
            }
            .navigationDestination(for: Task.self, destination: AddTaskView.init)
            .toolbar{
                Button("+", systemImage: "plus", action: addTask)
            }
        }
    }
    
    func addTask(){
        let task = Task()
        mc.insert(task)
        path = [task]
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
