import { describe, it, expect } from 'vite-plus/test';
import { render, screen } from '@testing-library/react';
import App from './App';

describe('App', () => {
  it('renders without crashing', () => {
    render(<App />);
    expect(screen.getByText(/Get started/i)).toBeInTheDocument();
  });

  it('renders counter button', () => {
    render(<App />);
    expect(screen.getByText(/Count is 0/i)).toBeInTheDocument();
  });
});
