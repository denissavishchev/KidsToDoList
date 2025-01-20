import SwiftUI

struct AddTaskView: View {
    
    @Bindable var task: Task
    
    var body: some View {
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

