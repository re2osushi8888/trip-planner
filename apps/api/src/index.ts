import { serve } from '@hono/node-server';
import { Hono } from 'hono';

const app = new Hono();

app.get('/', (c) => {
  console.log('hello!');
  return c.text('Hello World');
});

const port = Number(process.env['API_PORT']) || 4001;
console.log(`Server is running on http://localhost:${port}`);

serve({
  fetch: app.fetch,
  port,
});
