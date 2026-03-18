import { describe, it, expect } from 'vite-plus/test';
import { Hono } from 'hono';

describe('API', () => {
  it('returns hello world', async () => {
    const app = new Hono();
    app.get('/', (c) => c.text('Hello World'));

    const res = await app.request('/');
    expect(res.status).toBe(200);
    expect(await res.text()).toBe('Hello World');
  });
});
