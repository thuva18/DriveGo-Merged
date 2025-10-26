// Simple Chart.js fallback - minimal implementation for basic charts
(function() {
    if (window.Chart) return; // Don't override if Chart.js is already loaded
    
    console.log('Loading Chart.js fallback implementation');
    
    window.Chart = function(ctx, config) {
        this.ctx = ctx;
        this.config = config;
        this.canvas = ctx.canvas;
        
        // Simple drawing function
        this.draw = function() {
            const data = config.data;
            const canvas = ctx.canvas;
            const width = canvas.width;
            const height = canvas.height;
            
            // Clear canvas
            ctx.clearRect(0, 0, width, height);
            ctx.fillStyle = '#f8f9fa';
            ctx.fillRect(0, 0, width, height);
            
            // Draw simple text message
            ctx.fillStyle = '#374151';
            ctx.font = '16px Arial';
            ctx.textAlign = 'center';
            ctx.fillText('Chart data would appear here', width/2, height/2 - 20);
            ctx.fillText('Chart.js CDN failed to load', width/2, height/2 + 20);
            
            if (data && data.labels && data.datasets) {
                ctx.font = '12px Arial';
                ctx.fillStyle = '#6b7280';
                ctx.fillText('Data: ' + data.labels.length + ' labels, ' + data.datasets.length + ' datasets', width/2, height/2 + 50);
            }
        };
        
        this.draw();
        return this;
    };
    
    // Add required static properties
    Chart.register = function() {};
    Chart.defaults = {};
    Chart.version = 'fallback-1.0';
    
    console.log('Chart.js fallback loaded');
})();