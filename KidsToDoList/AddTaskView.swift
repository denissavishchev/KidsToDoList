import SwiftUI

struct AddTaskView: View {
    
    @State private var path = [Task]()
    @Environment(\.modelContext) var mc
    @State private var task = Task(name: "", details: "", deadline: Date(), type: .school)
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack{
            Button{
                addTask()
                dismiss()
            }label: {
                Text("Add task")
            }
            Form{
                TextField("Name", text: $task.name)
                TextField("Description", text: $task.details, axis: .vertical)
                DatePicker("Date", selection: $task.deadline)
                
                Section("Task type"){
                    Picker("Task type", selection: $task.type) {
                        ForEach(TaskType.allCases, id: \.self) { type in
                            Text(type.rawValue)
                                .tag(type)
                        }
                    }
                    .pickerStyle(.segmented)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    func addTask(){
        let task = Task(name: task.name, details: task.details, deadline: task.deadline, type: task.type)
        mc.insert(task)
        path = [task]
    }
    
}

//
//#Preview {
//    AddTaskView()
//}
