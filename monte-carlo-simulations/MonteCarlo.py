import random

def monte_carlo_pi(num_samples: int) -> float:
    inside_circle = 0
    for _ in range(num_samples):
        x, y = random.random(), random.random()
        if x**2 + y**2 <= 1:
            inside_circle += 1
    return (inside_circle / num_samples) * 4

if __name__ == "__main__":
    samples = 1_000_000
    pi_estimate = monte_carlo_pi(samples)
    print(f"Estimated π after {samples:,} samples: {pi_estimate:.6f}")
