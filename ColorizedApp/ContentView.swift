//
//  ContentView.swift
//  ColorizedApp
//
//  Created by Vovo on 13.06.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var sliderRedValue = Double.random(in: 0...255)
    @State private var sliderGreenValue = Double.random(in: 0...255)
    @State private var sliderBlueValue = Double.random(in: 0...255)
    
    @State private var textRedSlider = ""
    @State private var textGreenSlider = ""
    @State private var textBlueSlider = ""
    
    var body: some View {	
        
        ZStack {
            Color(hue: 0.6, saturation: 1, brightness: 0.75).ignoresSafeArea()
           
            VStack {
                RoundedRectangle(cornerRadius: 15)
                    .foregroundColor(Color(red: sliderRedValue/255, green: sliderGreenValue/255, blue: sliderBlueValue/255))
                    .frame(width: 370, height: 170)
                    .overlay(RoundedRectangle(cornerRadius: 15).stroke(.white, lineWidth: 2))
                
                Spacer().frame(height: 50)
                
                ColorSliderView(value: $sliderRedValue, textValue: $textRedSlider, sliderColor: .red)
                ColorSliderView(value: $sliderGreenValue, textValue: $textGreenSlider, sliderColor: .green)
                ColorSliderView(value: $sliderBlueValue, textValue: $textBlueSlider, sliderColor: .blue)
                
                Spacer()
            }
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        
                    }
                }
            }
            .padding()
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ColorSliderView: View {
    @Binding var value: Double
    @Binding var textValue: String
    @State private var isPresented = false
    
    let sliderColor: Color
    
    var body: some View {
        HStack {
            Text("\(lround(value))")
                .font(.system(size: 16))
                .foregroundColor(.white)
                .frame(width: 40)
                .multilineTextAlignment(.leading)
            
            Slider(value: $value, in: 0...255, step: 1)
                .accentColor(sliderColor)
            
            Spacer()
            TextField("\(lround(value))", text: $textValue)
                .font(.system(size: 16))
                .background()
                .cornerRadius(5)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 50)
                .multilineTextAlignment(.trailing)
                .keyboardType(.numberPad)
                
                .alert("Неправильное значение", isPresented: $isPresented, actions: {}) {
                    Text("Введите значение от 0 до 255")
                }
                
        }
    }
    private func checkValue() {
        if value > 255 {
            isPresented.toggle()
        }
        if value < 0 {
            isPresented.toggle()
        }
    }
}
