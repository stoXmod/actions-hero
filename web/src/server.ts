import app from './app';

const server = app.listen(5000, () => {
    console.log(`⚡️[server]: Server is running at http://localhost:5000`);
});

// For a graceful shutdown
process.on('SIGTERM', () => {
    server.close(() => {
        console.log('Process terminated');
    });
});

export default server;