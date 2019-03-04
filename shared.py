from IPython.display import display, HTML
from ipywidgets import IntProgress, Label, Layout
import time
import datetime

def progressify(iterable, n):
    start_time = time.time()
    progress = IntProgress(min=0, max=n, layout=Layout(width='100%'))
    text = Label(layout=Layout(width='100%'))
    display(progress)
    display(text)
    for it in iterable:
        yield it
        progress.value += 1
        elapsed_time = time.time() - start_time
        percent = progress.value * 100.0 / n
        progress.description = '%.1f%% (%s / %s)' % (percent, progress.value, n)
        text.value = 'elapsed %s' % datetime.timedelta(seconds=elapsed_time)
    progress.bar_style = 'success'
    
        
def progressify_list(l):
    return progressify(l, len(l))