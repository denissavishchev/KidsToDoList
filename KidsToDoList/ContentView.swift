import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Query var tasks: [Task]
    @State private var path = [Task]()
    
    var body: some View {
        NavigationStack(){
            NavigationLink(destination: AddTaskView()){
                Text("Add task")
            }
            ScrollView{
                ForEach(Array(tasks.enumerated()), id: \.element.id){index, task in
                    TaskTile(index: index, futureDate: task.deadline, name: task.name, description: task.details)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
