import os
import unittest
from PIL import Image, ImageDraw
from robot.libraries.BuiltIn import BuiltIn
from robot.api import logger


class VisualValidation:
    '''
    https://blog.rinatussenov.com/automating-manual-visual-regression-tests-with-python-and-selenium-be66be950196
    '''

    def __init__(self):
        # super.__init__()
        self.lib = BuiltIn().get_library_instance('SeleniumLibrary')
        self.robot_vars = {}
        self._driver = None  # internal attribute, don't use it in the methods, but "self.driver"

    def send_var_to_python(self, key, value):
        self.robot_vars[key] = value

    def get_driver(self):
        if self._driver is None:
            self._driver = self.lib.driver
        return self._driver

    def set_driver(self):
        self._driver = self.lib.driver

    def title_should_start_with(self, expected):
        seleniumlib = self.lib
        title = seleniumlib.get_title()
        if not title.startswith(expected):
            raise AssertionError("Title '%s' did not start with '%s'"
                                 % (title, expected))

    def vv_check(self, tag):
        self.tag = tag
        if not self.robot_vars["outdir"]:
            raise Exception('"outputdir" needs to be passd to Python via "send var to python"')
        self.html_link_path = self.robot_vars["version"] + '/images/'

        self.screenshots_path = self.robot_vars["outdir"] + '/' + self.html_link_path

        self.gold_html = self.html_link_path + tag + '_G.png'
        self.new_html = self.html_link_path + tag + '_N.png'

        self.gold = self.screenshots_path + tag + '_G.png'
        self.new = self.screenshots_path + tag + '_N.png'

        if not os.path.exists(self.screenshots_path):
            os.makedirs(self.screenshots_path)

        if os.path.exists(self.gold):
            self._screenshot(self.new)
            self._analyze()

        else:
            self._screenshot(self.gold)

    def _screenshot(self, file_with_path):
        self.lib.driver.save_screenshot(file_with_path)
        self.lib.driver.get_screenshot_as_png()
        self.write_to_robot_log("Finished taking screenshot")

    def _analyze(self):
        screenshot_gold = Image.open(self.gold)
        screenshot_new = Image.open(self.new)
        columns = 60
        rows = 80
        screen_width, screen_height = screenshot_gold.size
        diff = 0

        block_width = ((screen_width - 1) // columns) + 1  # this is just a division ceiling
        block_height = ((screen_height - 1) // rows) + 1

        for y in range(0, screen_height, block_height + 1):
            for x in range(0, screen_width, block_width + 1):
                region_gold = self.process_region(screenshot_gold, x, y, block_width, block_height)
                region_new = self.process_region(screenshot_new, x, y, block_width, block_height)

                if region_gold is not None and region_new is not None and region_new != region_gold:
                    draw = ImageDraw.Draw(screenshot_gold)
                    draw.rectangle((x, y, x + block_width, y + block_height), outline="red")
                    diff += 1

        screenshot_gold.save(self.screenshots_path + self.tag + '_R.png')

        if diff == 0:
            self.write_to_robot_log('Comparison done:  ' + self.tag + ' Images match')
            self.write_html_image_gold()
        else:
            self.write_html_image_diff(self.html_link_path + self.tag + '_R.png')
            raise Exception('Comparison done: ' + self.tag + ' Images are different.', diff)

    def process_region(self, image, x, y, width, height):
        region_total = 0

        # This can be used as the sensitivity factor, the larger it is the less sensitive the comparison
        factor = 100

        for coordinateY in range(y, y + height):
            for coordinateX in range(x, x + width):
                try:
                    pixel = image.getpixel((coordinateX, coordinateY))
                    region_total += sum(pixel) / 4
                except:
                    return

        return region_total / factor

    def write_to_robot_log(self, message):
        import logging

        logging.basicConfig()
        logging.root.setLevel(logging.INFO)
        logging.info(message)

    def write_html_image_gold(self):
        logger.info('<img style="border: 4px dashed #458b00;" src="' + self.gold_html + '"', html=True)

    def write_html_image_diff(self, path_image):
        logger.info(
            'Image with diffs highlighted in red between Gold and New Failed:')
        logger.info('<img style="border: 3px dashed #8b0000;" src="' + path_image + '"', html=True)
        logger.info('Gold:')
        logger.info('<img style="border: 4px dashed #458b00;" src="' + self.gold_html + '"', html=True)
        logger.info('New Failed:')
        logger.info('<img style="border: 4px dashed #ee0000;" src="' + self.new_html + '"', html=True)


if __name__ == "__main__":
    unittest.main()
