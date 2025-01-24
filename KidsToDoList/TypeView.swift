import SwiftUI

struct TypeView: View {
    
    var images: [String] = ["Book", "Piano", "Bike", "Rocket", "Cleaner"]
    var colors: [Color] = [.red, .blue, .brown, .yellow, .green, .orange, .indigo, .pink, .purple, .mint]
    @Binding var selectedImage: String
    @Binding var selectedColor: Color
    var body: some View {
        VStack {
            HStack(spacing: 4){
                ForEach(images, id: \.self){image in
                    ZStack {
                        Circle()
                            .stroke(selectedImage == image ? selectedColor : .clear, lineWidth: 3)
                            .frame(width: 62)
                            .shadow(color: selectedImage == image ? .black : .clear, radius: 4, x: 2, y: 4)
                        Circle()
                            .frame(width: 60)
                        Image(image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 70)
                        .clipShape(Circle())
                    }
                    .onTapGesture {
                        withAnimation{
                            selectedImage = image
                        }
                    }
                }
            }
            .padding(.bottom, 20)
            
            HStack{
                ForEach(colors, id:\.self){color in
                    ZStack{
                        Circle()
                            .frame(width: 30)
                            .foregroundColor(color)
                        Circle()
                            .frame(width: 10)
                            .foregroundColor(selectedColor == color ? .black : .clear)
                    }
                    .onTapGesture {
                        withAnimation{
                            selectedColor = color
                        }
                    }
                }
            }
        }
    }
}

//#Preview {
//    TypeView()
//}
