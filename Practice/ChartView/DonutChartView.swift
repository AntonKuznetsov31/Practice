//
//  DonutChart.swift
//  Practice
//
//  Created by Anton Kuznetsov on 16/04/2025.
//

import SwiftUI

struct DonutChartView: View {
    
    struct ChartData {
        let color: Color
        let percent: CGFloat
        var value: CGFloat
    }
    
    private let currentSegmentIndex: Int
    private let chartData: [ChartData]
    
    init(currentSegmentIndex: Int) {
        self.currentSegmentIndex = currentSegmentIndex
        self.chartData = Self.getDataForChart(data: mockData)
    }
    
    private var currentSegmentTitle: String {
        return String(format: "%.0f", chartData[currentSegmentIndex].percent) + "%"
    }
    
    static private func getDataForChart(data: [ExternalChartData]) -> [ChartData] {
        var chartData = [ChartData]()
        for data in data {
            let data = ChartData(color: data.color, percent: data.percent, value: 0)
            chartData.append(data)
        }
        var value: CGFloat = 0
        for i in 0..<chartData.count {
            value += chartData[i].percent
            chartData[i].value = value
        }
        return chartData
    }
    
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.white)
            VStack {
                ZStack {
                    ForEach(0..<chartData.count, id: \.self) { index in
                        Circle()
                            .trim(from: index == 0 ? 0.004: (chartData[index - 1].value / 100) + 0.004,
                                  to: (chartData[index].value / 100) - 0.004)
                            .stroke(chartData[index].color, lineWidth: 25)
                            .opacity(index == currentSegmentIndex ? 1 : 0.25)
                    }
                    Text(currentSegmentTitle)
                        .font(.body)
                        .tint(.black)
                }
            }
            .frame(width: 95, height: 95)
            .accessibilityLabel(Text(currentSegmentTitle))
        }
        .frame(width: 130, height: 130)
    }
    
}

struct ExternalChartData {
    let color: Color
    let percent: CGFloat
}

private let mockData: [ExternalChartData] = [
    .init(color: Color(#colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)), percent: 3.0),
    .init(color: Color(#colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)), percent: 2.0),
    .init(color: Color(#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)), percent: 15.0),
    .init(color: Color(#colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)), percent: 20.0),
    .init(color: Color(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)), percent: 10.0),
    .init(color: Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)), percent: 40.0),
    .init(color: Color(#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)), percent: 10.0),
]
