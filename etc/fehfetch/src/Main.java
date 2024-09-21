import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics2D;
import java.awt.GraphicsDevice;
import java.awt.GraphicsEnvironment;
import java.awt.image.BufferedImage;
import java.io.FileInputStream;
import java.nio.file.Path;
import java.util.Random;
import java.util.Scanner;
import javax.imageio.ImageIO;

public class Main {
	public static void main(final String[] args) throws Exception {
		final Args a = new Args(args);
		if (a.has("--help") || a.has("-h")) {
			System.out.println("usage:");
			System.out.println("\t--font | -f <font>");
			System.out.println("\t--dir | -d <dir>");
			return;
		}
		new Main(a);
	}

	private final String[] text;
	private final int textWidth;
	private Font font = null;

	private String or(final String... s) {
		for (final String a : s) {
			if (a == null)
				continue;
			return a;
		}
		return new String();
	}

	private Main(final Args args) throws Exception {
		final Path path = Path.of(or(args.get("--dir"), args.get("-d"), "."));
		{
			final Scanner scanner = new Scanner(System.in);
			this.text = scanner.useDelimiter("\\Z").next().split("\n");
			scanner.close();
			int w = 0;
			for (final String s : text)
				w = Math.max(w, s.length());
			this.textWidth = w;
		}
		try {
			this.font = Font
					.createFont(Font.TRUETYPE_FONT,
							new FileInputStream(or(args.get("--font"), args.get("-f"))))
					.deriveFont(16.0f);
		} catch (Exception e) {
		}
		final GraphicsDevice[] devices = GraphicsEnvironment.getLocalGraphicsEnvironment().getScreenDevices();
		for (int i = 0; i < devices.length; i++)
			ImageIO.write(getImage(devices[i]), "png", path.resolve(String.valueOf(i)).toFile());
	}

	private BufferedImage getImage(final GraphicsDevice device) {
		final int w = device.getDisplayMode().getWidth(), h = device.getDisplayMode().getHeight();
		final BufferedImage image = new BufferedImage(w, h, BufferedImage.TYPE_INT_RGB);
		final Graphics2D ctx = image.createGraphics();
		final Random r = new Random();
		if (font != null)
			ctx.setFont(font);

		{
			final int col = 12;
			Color bg = new Color(0x202020 + 0x030303);
			final int one = Math.min(w, h) / 2 / col;
			for (int j = 0; j < col; j++) {
				bg = new Color(Math.max(bg.getRed() - 0x03, 0), Math.max(bg.getGreen() - 0x03, 0),
						Math.max(bg.getBlue() - 0x03, 0), bg.getAlpha());
				ctx.setColor(bg);
				ctx.fillRect(j * one, j * one, w - j * one * 2, h - j * one * 2);
			}
		}

		for (int x = 0; x < w; x += 2) {
			for (int y = 0; y < h; y += 2) {
				final int distance = (w / 2 - x) * (w / 2 - x) + (h / 2 - y) * (h / 2 - y);
				final float a = distance / (float) (w * w + h * h);
				ctx.setColor(new Color(r.nextFloat(), r.nextFloat(), r.nextFloat(), Math.max((0.05f - a) * 3, 0)));
				if (r.nextFloat() < a * 48.0f)
					ctx.fillRect(x, y, 2, 2);
			}
		}

		{
			final int fx = ctx.getFontMetrics(ctx.getFont()).charWidth(' '),
					fy = ctx.getFontMetrics(ctx.getFont()).getHeight();
			for (int i = 0; i < text.length; i++) {
				final String line = text[i];
				for (int x = 0; x < line.length(); x++) {
					ctx.setColor(new Color(r.nextInt(256), r.nextInt(256), r.nextInt(256)));
					ctx.drawString(String.valueOf(line.charAt(x)), w / 2f + ((-textWidth / 2f + x) * fx),
							h / 2f + ((-text.length / 2f + i + 1) * fy));
				}
			}
		}

		return image;
	}
}
