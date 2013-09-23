Event.observe(document, 'dom:loaded', function() {
    
    prettyPrint();
    
    HumbleFinance.trackFormatter = function (obj) {
        
        var x = Math.floor(obj.x);
        var data = jsonData[x];
        var text = data.date + " Level: " + data.level + "  YOY: " + data.change + "%" + " YTD: " + data.ytd + "%";
        
        return text; //black square
    };
    
    HumbleFinance.yTickFormatter = function (n) {
        
        if (n == this.axes.y.max) {
            return false;
        }
        
        return n; //y axis labels
    };
    
    HumbleFinance.xTickFormatter = function (n) { 
        
        if (n == 0) {
            return false;
        }
        
        var date = jsonData[n].date;
        date = date.split('-');
        date = date[0];
        
        return date; 
    }
    
    HumbleFinance.init('finance', priceData, volumeData, summaryData);

    //HumbleFinance.setFlags(flagData); 
    var xaxis = HumbleFinance.graphs.summary.axes.x;
    var prevSelection = HumbleFinance.graphs.summary.prevSelection;
    var xmin = xaxis.p2d(prevSelection.first.x);
    var xmax = xaxis.p2d(prevSelection.second.x);
    $('dateRange').update('start:<strong>' + jsonData[xmin].date + '</strong> end:<strong>' + jsonData[xmax].date + '</strong>');
    Event.observe(HumbleFinance.containers.summary, 'flotr:select', function (e) {
        
        var area = e.memo[0];
        xmin = Math.floor(area.x1);
        xmax = Math.ceil(area.x2);
        
        var date1 = jsonData[xmin].date;
        var date2 = jsonData[xmax].date;
        
	    $('dateRange').update('start:<strong>' + jsonData[xmin].date + '</strong> end:<strong>' + jsonData[xmax].date + '</strong>');
    });
});


