import java.util.Arrays;

public class Args {
	private final String[] args;

	public Args(final String[] args) {
		this.args = args;
	}

	public boolean has(final String arg) {
		for (final String s : args) {
			if (arg.equals(s))
				return true;
		}
		return false;
	}

	public String get(final String arg) {
		for (int i = args.length - 2; i >= 0; i--) {
			if (arg.equals(args[i]))
				return args[i + 1];
		}
		return null;
	}

	@Override
	public String toString() {
		return Arrays.toString(args);
	}
}
