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
            ScrollView{
                ForEach(tasks){task in
                    TaskTile(futureDate: task.deadline)
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
