local gl = require('galaxyline')
local colors = require('galaxyline.theme').default
local cb_colors = require('colorbuddy').colors
local condition = require('galaxyline.condition')
local gls = gl.section
gl.short_line_list = {'NvimTree','vista','dbui','packer'}

cb_red = cb_colors.hulk_pants:to_rgb()
cb_orange = cb_colors.vapor_blue:to_rgb()
cb_yellow = cb_colors.deep_purple:to_rgb()
cb_green = cb_colors.guppie_green:to_rgb()
cb_blue = cb_colors.azure:to_rgb()
cb_magenta = cb_colors.dark_pink:to_rgb()
cb_cyan = cb_colors.ice_cyan_dark:to_rgb()
cb_bg = cb_colors.eerie_black:to_rgb()
cb_fg = cb_colors.bone_white:to_rgb()

gls.left[1] = {
  RainbowRed = {
    provider = function() return '▊ ' end,
    highlight = {cb_blue,cb_bg}
  },
}
gls.left[2] = {
  ViMode = {
    provider = function()
      -- auto change color according the vim mode
      local mode_color = {n = cb_red, i = cb_green,v=cb_blue,
                          [''] = cb_blue,V=cb_blue,
                          c = cb_magenta,no = cb_red,s = cb_orange,
                          S=cb_orange,[''] = cb_orange,
                          ic = cb_yellow,R = cb_violet,Rv = cb_violet,
                          cv = cb_red,ce=cb_red, r = cb_cyan,
                          rm = cb_cyan, ['r?'] = cb_cyan,
                          ['!']  = cb_red,t = cb_red}
      vim.api.nvim_command('hi GalaxyViMode guifg='..mode_color[vim.fn.mode()])
      return '  '
    end,
    highlight = {cb_red,cb_bg,'bold'},
  },
}
gls.left[3] = {
  FileSize = {
    provider = 'FileSize',
    condition = condition.buffer_not_empty,
    highlight = {cb_fg,cb_bg}
  }
}
gls.left[4] ={
  FileIcon = {
    provider = 'FileIcon',
    condition = condition.buffer_not_empty,
    highlight = {require('galaxyline.provider_fileinfo').get_file_icon_color,cb_bg},
  },
}

gls.left[5] = {
  FileName = {
    provider = 'FileName',
    condition = condition.buffer_not_empty,
    highlight = {cb_magenta,cb_bg,'bold'}
  }
}

gls.left[6] = {
  LineInfo = {
    provider = 'LineColumn',
    separator = ' ',
    separator_highlight = {'NONE',cb_bg},
    highlight = {cb_fg,cb_bg},
  },
}

gls.left[7] = {
  PerCent = {
    provider = 'LinePercent',
    separator = ' ',
    separator_highlight = {'NONE',cb_bg},
    highlight = {cb_fg,cb_bg,'bold'},
  }
}

gls.mid[1] = {
  DiagnosticError = {
    provider = 'DiagnosticError',
    icon = '  ',
    highlight = {cb_red,cb_bg}
  }
}
gls.mid[2] = {
  DiagnosticWarn = {
    provider = 'DiagnosticWarn',
    icon = '  ',
    highlight = {cb_yellow,cb_bg},
  }
}

gls.mid[3] = {
  DiagnosticHint = {
    provider = 'DiagnosticHint',
    icon = '  ',
    highlight = {cb_cyan,cb_bg},
  }
}

gls.mid[4] = {
  DiagnosticInfo = {
    provider = 'DiagnosticInfo',
    icon = '  ',
    highlight = {cb_blue,cb_bg},
  }
}

gls.mid[5] = {
  ShowLspClient = {
    provider = 'GetLspClient',
    condition = function ()
      local tbl = {['dashboard'] = true,['']=true}
      if tbl[vim.bo.filetype] then
        return false
      end
      return true
    end,
    icon = ' LSP:',
    highlight = {cb_cyan,cb_bg,'bold'}
  }
}

gls.mid[6] = {
  GitIcon = {
    provider = function() return '  ' end,
    condition = condition.check_git_workspace,
    separator = ' ',
    separator_highlight = {'NONE',cb_bg},
    highlight = {cb_violet,cb_bg,'bold'},
  }
}

gls.mid[7] = {
  GitBranch = {
    provider = 'GitBranch',
    condition = condition.check_git_workspace,
    highlight = {cb_violet,cb_bg,'bold'},
  }
}

gls.right[1] = {
  FileEncode = {
    provider = 'FileEncode',
    condition = condition.hide_in_width,
    separator = ' ',
    separator_highlight = {'NONE',cb_bg},
    highlight = {cb_green,cb_bg,'bold'}
  }
}

gls.right[2] = {
  FileFormat = {
    provider = 'FileFormat',
    condition = condition.hide_in_width,
    separator = ' ',
    separator_highlight = {'NONE',cb_bg},
    highlight = {cb_green,cb_bg,'bold'}
  }
}

gls.right[3] = {
  DiffAdd = {
    provider = 'DiffAdd',
    condition = condition.hide_in_width,
    icon = '  ',
    highlight = {cb_green,cb_bg},
  }
}
gls.right[4] = {
  DiffModified = {
    provider = 'DiffModified',
    condition = condition.hide_in_width,
    icon = ' 柳',
    highlight = {cb_orange,cb_bg},
  }
}
gls.right[5] = {
  DiffRemove = {
    provider = 'DiffRemove',
    condition = condition.hide_in_width,
    icon = '  ',
    highlight = {cb_red,cb_bg},
  }
}

gls.right[6] = {
  RainbowBlue = {
    provider = function() return ' ▊' end,
    highlight = {cb_blue,cb_bg}
  },
}

gls.short_line_left[1] = {
  BufferType = {
    provider = 'FileTypeName',
    separator = ' ',
    separator_highlight = {'NONE',cb_bg},
    highlight = {cb_blue,cb_bg,'bold'}
  }
}

gls.short_line_left[2] = {
  SFileName = {
    provider =  'SFileName',
    condition = condition.buffer_not_empty,
    highlight = {cb_fg,cb_bg,'bold'}
  }
}

gls.short_line_right[1] = {
  BufferIcon = {
    provider= 'BufferIcon',
    highlight = {cb_fg,cb_bg}
  }
}
