//
//  ContentView.swift
//  ColorizedApp
//
//  Created by Vovo on 13.06.2023.
//

import SwiftUI

struct ContentView: View {
    private enum Field {
        case red
        case green
        case blue
    }
    
    @State private var sliderRedValue = Double.random(in: 0...255)
    @State private var sliderGreenValue = Double.random(in: 0...255)
    @State private var sliderBlueValue = Double.random(in: 0...255)

    @FocusState private var focusedField: Field?

    var body: some View {
        
        ZStack {
            Color(hue: 0.6, saturation: 1, brightness: 0.75)
                .ignoresSafeArea()
                .onTapGesture {
                    focusedField = nil
                }
            VStack {
                RoundedRectangle(cornerRadius: 15)
                    .foregroundColor(Color(red: sliderRedValue/255, green: sliderGreenValue/255, blue: sliderBlueValue/255))
                    .frame(width: 370, height: 170)
                    .overlay(RoundedRectangle(cornerRadius: 15).stroke(.white, lineWidth: 2))
                
                Spacer().frame(height: 50)
                
                ColorSliderView(sliderValue: $sliderRedValue, sliderColor: .red)
                    .focused($focusedField, equals: .red)
                ColorSliderView(sliderValue: $sliderGreenValue, sliderColor: .green)
                    .focused($focusedField, equals: .green)
                ColorSliderView(sliderValue: $sliderBlueValue, sliderColor: .blue)
                    .focused($focusedField, equals: .blue)
                    
                Spacer()
            }
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        focusedField = nil
                    }
                }
            }
            .padding()
        }
    }
}
// MARK: - Setup Sliders & TextField
struct ColorSliderView: View {
    @Binding var sliderValue: Double
    @State var textValue = ""
    @State private var isPresented = false
    
    let sliderColor: Color
    
    var body: some View {
        HStack {
            Text("\(lround(sliderValue))")
                .font(.system(size: 16))
                .foregroundColor(.white)
                .frame(width: 40)
                .multilineTextAlignment(.leading)
            
            Slider(value: $sliderValue, in: 0...255, step: 1)
                .accentColor(sliderColor)
                .onChange(of: sliderValue) {
                    textValue = sliderValue.formatted()
                }
            
            Spacer()
            
            TextField("", text: $textValue) { _ in
                withAnimation { checkValue() }
            }
                .font(.system(size: 16))
                .background()
                .cornerRadius(5)
                .textFieldStyle(.roundedBorder)
                .frame(width: 50)
                .multilineTextAlignment(.trailing)
                .keyboardType(.numberPad)
                .alert("Неправильное значение", isPresented: $isPresented, actions: {}) {
                Text("Введите значение от 0 до 255")
                }
        }
        .onAppear {textValue = "\(lround(sliderValue))"}
    }
   
    private func checkValue() {
        if let value = Double(textValue), (0...255).contains(value) {
            sliderValue = value
            return
        }
        isPresented.toggle()
        sliderValue = 0.0
        textValue = "0"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
