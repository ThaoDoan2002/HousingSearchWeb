function drawChartRevenue(ctx, labels, data, title = "Số lượng") {
    let colors = [];
    for (let i = 0; i < data.length; i++)
        colors.push(`rgba(${parseInt(Math.random() * 255)}, 
        ${parseInt(Math.random() * 255)}, 
        ${parseInt(Math.random() * 255)}, 0.7)`);

    new Chart(ctx, {
        type: 'bar',
        data: data,
        options: {
            plugins: {
                title: {
                    display: true,
                    text: title
                },
            },
            responsive: true,
            scales: {
                x: {
                    stacked: true,
                },
                y: {
                    stacked: true
                }
            }
        }
    });
}
